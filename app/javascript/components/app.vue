<template>
  <div>
    <p>{{ message }}</p>
    <p>{{ user.email }}</p>
    <router-view></router-view>
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

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
