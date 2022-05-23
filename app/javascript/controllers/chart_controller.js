import { Controller } from "@hotwired/stimulus";
import Chart from 'chart.js/auto';

export default class extends Controller {
    connect() {
        this.render();
    }

    render() {
        if (!this.ele) return;

        const ctx = this.ele.getContext('2d');

        this.graph = new Chart(ctx, { type: 'line', data: this.data, options: this.options });
    }

    get ele() {
        return this._ele = this._ele || document.getElementById("YOUR_ELEMENT_ID");
    }

    get metric() {
        return this._metric = this._metric || this.element.dataset.metric;
    }

    get unit() {
        return this._unit = this._unit || this.element.dataset.unit;
    }

    get metrics() {
        return this._metrics = this._metrics || JSON.parse(document.querySelector('[data-metrics]').dataset.metrics);
    }

    get options() {
        const defaultOptions = { responsive: true, maintainAspectRatio: false };
        return defaultOptions;
    }

    get data() {
        return { labels: this.labels, datasets: this.datasets };
    }

    get labels() {
        return this._labels = this._labels || this.metrics.map((m) => new Date(m.updated_at).toDateString());
    }

    get datasets() {
        console.log(this.metrics)
        return [{
            label: `Nr zamowienia / cena`,
            data: this.metrics,
            fill: false,
            borderColor: 'rgb(75, 192, 192)',
            tension: 0.1
        }];
    }
}