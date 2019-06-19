<template>
  <div class="page-container">
    <md-app>
      <md-app-toolbar class="md-primary">
        <span class="md-title" style="flex: 1">{{ message }}</span>
        <md-button>Hello</md-button>
        <md-button>World</md-button>
      </md-app-toolbar>
      <md-app-content>
        <p class='md-display-1'>{{ user.email }}</p>
        <router-view></router-view>
      </md-app-content>
    </md-app>
  </div>
</template>

<script>
import router from '../router.js';

export default {
  props: ['user-json'],
  router,
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  computed: {
    user () {
      if (this.userJson) {
        console.log(this.userJson)
        return JSON.parse(this.userJson);
      } else {
        return {};
      }
    }
  },
  mounted () {
    console.log(this.$router);
  }
}
</script>
