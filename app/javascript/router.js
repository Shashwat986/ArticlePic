import VueRouter from 'vue-router';
import Vue from 'vue/dist/vue.esm.js';

Vue.use(VueRouter);

import * as Components from './components';

export default new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/test',
      component: Components.Html
    }
  ]
});
