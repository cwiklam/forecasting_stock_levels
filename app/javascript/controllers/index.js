// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
// import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
// eagerLoadControllersFrom("controllers", application)

import HelloController from "./hello_controller"
import OrderFormController from "./order_form_controller"
import ChartController from "./chart_controller"
import ForecastingchartsController from "./forecastingcharts_controller"
application.register("chart", ChartController)
application.register("hello", HelloController)
application.register("order-form", OrderFormController)
application.register("forecastingcharts", ForecastingchartsController)
// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
