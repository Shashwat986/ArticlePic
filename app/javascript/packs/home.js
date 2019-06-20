/* eslint no-console: 0 */

import Vue from 'vue/dist/vue.esm.js';
import App from '../components/app.vue'

require('material.js');

import RestfulVue from '../restful_vue.js';
import ajaxRoutes from '../ajax_routes.js';

Vue.use(RestfulVue, ajaxRoutes)

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    el: "#home",
    components: {
      app: App
    }
  })
})

// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: () => {
//       return {
//         message: "Can you say hello?"
//       }
//     },
//     components: { App }
//   })
// })
