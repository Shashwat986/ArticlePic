<template>
  <div>
    <iframe v-if="restfulLoaded" :src="restfulData[0].url" height="500" class="md-image"></iframe>
  </div>
</template>

<script>
export default {
  props: ['id'],
  data: function () {
    return {
      fetchData: [ 'document#' + this.id ]
    };
  }
}
</script>

<style scoped>
  iframe {
    width: 100%;
  }
</style>
