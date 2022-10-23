import {Controller} from "@hotwired/stimulus";
import Chart from 'chart.js/auto';

export default class extends Controller {
    static targets = ['option']

    connect() {
        this.count = this.optionTarget.dataset.count
        this.max = this.optionTarget.dataset.max
        this.yMin = parseInt(this.optionTarget.dataset.ymin) > 0 ? 0 : parseInt(this.optionTarget.dataset.ymin)
        this.yMax = ((parseInt(this.max) + 1000) / 1000 ) * 1000
        console.log(this.yMin)
        console.log(this.yMax)
        this.render();
    }

    render() {
        if (!this.ele) return;

        const ctx = this.ele.getContext('2d');
        const color = (parseFloat(this.count) < 0) ? 'rgb(240, 150, 150, 0.4)' : 'rgb(60, 200, 240, 0.4)'
        this.config = {
            data: {
                datasets: [{
                    type: 'bar',
                    label: 'Zasoby',
                    data: [0, this.count, 0],
                    yAxisID: 'y',
                    borderColor: 'rgba(60, 200, 240, 0.4)',
                    backgroundColor: color
                }, {
                    type: 'line',
                    label: 'Maksymalny stan',
                    data: [this.max, this.max, this.max],
                    yAxisID: 'y',
                    borderColor: 'rgba(50, 255, 50, 0.7)',
                    pointBackgroundColor: 'rgba(50, 255, 50, 0)',
                    pointBorderColor: 'rgba(50, 255, 50, 0)'
                }, {
                    type: 'line',
                    label: 'Stan średni',
                    data: [parseInt(String(this.max * 0.6)), parseInt(String(this.max * 0.6)), parseInt(String(this.max * 0.6))],
                    yAxisID: 'y',
                    borderColor: 'rgba(255, 255, 50, 0.7)',
                    pointBackgroundColor: 'rgba(255, 255, 50, 0)',
                    pointBorderColor: 'rgba(255, 255, 50, 0)'
                }, {
                    type: 'line',
                    label: 'Stan niski',
                    data: [parseInt(String(this.max * 0.3)), parseInt(String(this.max * 0.3)), parseInt(String(this.max * 0.3))],
                    yAxisID: 'y',
                    borderColor: 'rgba(255, 50, 50, 0.7)',
                    pointBackgroundColor: 'rgba(255, 50, 50, 0)',
                    pointBorderColor: 'rgba(255, 50, 50, 0)'
                }, {
                    type: 'line',
                    label: 'Stan niski',
                    data: [0, 0, 0],
                    yAxisID: 'y',
                    borderColor: 'rgba(255, 255, 255, 0.7)',
                    pointBackgroundColor: 'rgba(255, 255, 255, 0)',
                    pointBorderColor: 'rgba(255, 255, 255, 0)'
                }],
                labels: ['', 'Zasoby', '']
            },
            options: this.options
        }

        this.graph = new Chart(ctx, this.config);
    }

    get ele() {
        return this._ele = this._ele || document.getElementById(`YOUR_ELEMENT_ID_${this.optionTarget.dataset.number}`);
    }

    get options() {
        const defaultOptions = {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                y: {
                    id: 'y',
                    min: this.yMin,
                    max: this.yMax
                }
            }
        };
        return defaultOptions;
    }
}