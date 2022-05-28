import {Controller} from "@hotwired/stimulus";
import Chart from 'chart.js/auto';

export default class extends Controller {
    static targets = ['labels', 'max', 'available', 'url']

    connect() {
        this.render();
        this.refresh()
    }

    disconnect() {

    }

    render() {
        if (!this.ele) return;

        const ctx = this.ele.getContext('2d');

        this.graph = new Chart(ctx, this.config);
    }

    refresh() {
        const urlTarget = this.urlTarget
        const chart = this.graph
        setInterval(function () {
            fetch(urlTarget.dataset.url, {
                method: "GET",
                headers: {
                    "Content-Type": "application/json",
                    "Accept": "application/json"
                }
            }).then(response => response.json())
                .then(data => {
                    const labelsArray = []
                    const maxArray = []
                    const availableArray = []
                    Object.keys(data).map(function (key, index) {
                        labelsArray.push(data[key].name)
                        maxArray.push(parseInt(data[key].max))
                        availableArray.push(parseInt(data[key].availability))
                    })
                    chart.data.datasets[1].data = availableArray
                    chart.data.datasets[0].data = maxArray
                    chart.data.labels = labelsArray
                    chart.update();
                })
                .catch(err => console.log(err))
        }, 5000);
    }

    get ele() {
        return this._ele = this._ele || document.getElementById("YOUR_ELEMENT_ID");
    }

    get metrics1() {
        const metric = this.maxTarget.dataset.metrics
        const result = []
        metric.substr(1, metric.length - 2).split(', ').map(function (item) {
            result.push(parseInt(item));
        });
        return result
    }

    get metrics2() {
        const metric = this.availableTarget.dataset.metrics
        const result = []
        metric.substr(1, metric.length - 2).split(', ').map(function (item) {
            result.push(parseInt(item));
        });
        return result
    }

    get options() {
        const defaultOptions = {responsive: true, maintainAspectRatio: false};
        return defaultOptions;
    }

    get data() {
        return {labels: this.labels, datasets: this.datasets};
    }

    get labels() {
        return this._labels = this._labels || JSON.parse(this.labelsTarget.dataset.labels);
    }

    get config() {
        const config = {
            data: this.data,
            type: 'line',
            options: {
                color: 'rgb(200, 200, 200)',
                responsive: true,
                plugins: {
                    legend: {
                        position: 'bottom',
                    },
                    title: {
                        display: true,
                        text: 'Stany magazynowe'
                    }
                },
                scales: {
                    yAxes: [{
                        ticks: {
                            min: 0,
                            max: 15000
                        }
                    }]
                },
            }
        }
        return config
    }

    get data() {
        const metrics1 = this.metrics1
        const metrics2 = this.metrics2
        const result = {
            labels: this.labels,
            datasets: [
                {
                    label: `Maksymalna pojemność`,
                    data: metrics1,
                    fill: false,
                    borderColor: 'rgb(192, 75, 192)',
                    color: 'rgb(200, 200, 200)',
                    backgroundColor: 'rgba(250, 75, 192, 0.5)',
                    tension: 0.1
                },
                {
                    type: 'bar',
                    label: `Dostępne zasoby`,
                    data: metrics2,
                    fill: false,
                    borderColor: 'rgb(75, 192, 192)',
                    backgroundColor: 'rgba(75,192,250, 0.5)',
                    color: 'rgb(200, 200, 200)',
                    tension: 0.1
                }
            ]
        }
        return result
    }
}