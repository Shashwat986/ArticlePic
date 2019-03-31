<template>
  <div>
    <p>{{ message }}</p>
    <p>{{ user.email }}</p>
  </div>
</template>

<script>
export default {
  props: ['user-json'],
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  computed: {
    user () {
      console.log(this.userJson)
      if (this.userJson)
        return JSON.parse(this.userJson);
      else
        return null;
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
