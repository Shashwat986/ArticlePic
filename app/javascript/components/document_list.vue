<template>
  <div>
    <md-card v-for="doc in restfulData['documents']" v-if="restfulLoaded">
      <md-card-header>
        <div class="md-title">{{ doc.title }}</div>
        <md-card-media>
          <img :src="doc.images[0].url">
        </md-card-media>
      </md-card-header>

      <md-card-content>
        {{ doc.text }}

        <br>

        <md-button v-for="tag in doc.keywords" class="md-raised md-dense">
          {{ tag }}
        </md-button>
      </md-card-content>

      <md-card-actions>
        <md-button :to="'/document/' + doc.id">See Document</md-button>
      </md-card-actions>
    </md-card>
  </div>
</template>

<script>
export default {
  fetchData: ['documents']
};
</script>
