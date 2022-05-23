import {Controller} from "@hotwired/stimulus";
import Chart from 'chart.js/auto';

export default class extends Controller {
    static targets = ['labels', 'max', 'available']

    connect() {
        this.render();
    }

    render() {
        if (!this.ele) return;

        const ctx = this.ele.getContext('2d');

        this.graph = new Chart(ctx, this.config);
    }

    get ele() {
        return this._ele = this._ele || document.getElementById("YOUR_ELEMENT_ID");
    }

    get metrics1() {
        return this.maxTarget.dataset.metrics;
    }

    get metrics2() {
        return this.availableTarget.dataset.metrics;
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
        console.log(this.data)
        const config = {
            data: this.data,
            type: 'line',
            options: {
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
        console.log(this.metrics1)
        console.log(this.metrics2)
        const metrics1 = this.metrics1.substr(1,this.metrics1.length - 2).split(', ').map(function (item) {
            return parseInt(item);
        });
        const metrics2 = this.metrics2.substr(1,this.metrics2.length - 2).split(', ').map(function (item) {
            return parseInt(item);
        });
        const result = {
            labels: this.labels,
            datasets: [
                {
                    label: `Maksymalna pojemność`,
                    data: metrics1,
                    fill: false,
                    borderColor: 'rgb(192, 75, 192)',
                    backgroundColor: 'rgba(250, 75, 192, 0.5)',
                    tension: 0.1
                },
                {
                    label: `Dostępne zasoby`,
                    data: metrics2,
                    fill: false,
                    borderColor: 'rgb(75, 192, 192)',
                    backgroundColor: 'rgba(75,192,250, 0.5)',
                    tension: 0.1
                }
            ]
        }
        return result
    }
}