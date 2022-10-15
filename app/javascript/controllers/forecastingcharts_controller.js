import {Controller} from "@hotwired/stimulus";
import Chart from 'chart.js/auto';

export default class extends Controller {
    static targets = ['option']

    connect() {
        this.render();
        console.log('forecasting_charts')
    }

    render() {
        if (!this.ele) return;

        const ctx = this.ele.getContext('2d');

        this.config = {
            data: {
                datasets: [{
                    type: 'bar',
                    label: 'Bar Dataset',
                    data: [10, 20, 30, 40],
                    borderColor: 'rgb(255, 99, 132)',
                    backgroundColor: 'rgba(255, 99, 132, 0.2)'
                }, {
                    type: 'line',
                    label: 'Line Dataset',
                    data: [50, 50, 50, 50],
                    borderColor: 'rgba(50, 255, 50, 0.7)',
                    pointBackgroundColor: 'rgba(50, 255, 50, 0)',
                    pointBorderColor: 'rgba(50, 255, 50, 0)'
                }, {
                    type: 'line',
                    label: 'Line Dataset',
                    data: [40, 40, 40, 40],
                    borderColor: 'rgba(255, 255, 50, 0.7)',
                    pointBackgroundColor: 'rgba(255, 255, 50, 0)',
                    pointBorderColor: 'rgba(255, 255, 50, 0)'
                }, {
                    type: 'line',
                    label: 'Line Dataset',
                    data: [30, 30, 30, 30],
                    borderColor: 'rgba(255, 50, 50, 0.7)',
                    pointBackgroundColor: 'rgba(255, 50, 50, 0)',
                    pointBorderColor: 'rgba(255, 50, 50, 0)'
                }],
                labels: ['January', 'February', 'March', 'April']
            },
            options: this.options
        }

        this.graph = new Chart(ctx, this.config);
    }

    get ele() {
        return this._ele = this._ele || document.getElementById(`YOUR_ELEMENT_ID_${this.optionTarget.dataset.number}`);
    }

    get options() {
        const defaultOptions = {responsive: true, maintainAspectRatio: false};
        return defaultOptions;
    }
}