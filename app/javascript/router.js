import VueRouter from 'vue-router';
import Vue from 'vue/dist/vue.esm.js';

Vue.use(VueRouter);

import * as Components from './components';

console.log(Components)

export default new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      component: Components.DocumentList
    },
    {
      path: '/test',
      component: Components.Html
    }
  ]
});
