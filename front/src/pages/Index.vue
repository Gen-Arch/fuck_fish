<template>
    <div id="body">
        <div class="card" v-for="(item, index) in contents" :key="index">
            <div class="card-title">{{item.title}}</div>
            <div class="card-body">{{ item.text }}</div>
        </div>
    </div>
</template>

<script>
import Axios from '../lib/axios.js';

export default {
  data() {
    return {
      contents: []
    };
  },
  mounted() {
    Axios.get('elastic/search')
    .then((response) => {
        // console.log(response.data.hits.hits.map(v=>v._source));
        console.log(this.contents)
        this.contents = response.data.hits.hits.map(v=>v._source);
    })
    .catch((error) => {
        console.log('ERROR!! occurred in Backend.')
        console.log(errr)
    });
  }
};
</script>

<style lang="scss" scoped>
  #body {
    flex-grow: 2;
    height: 100%;
    .card {
      font-size: 16px;
      background: rgba(30, 30, 30, 0.3);
      margin: 10px;
      padding: 5px;
      box-shadow: 2px 2px 2px 2px rgba(73, 73, 73, 0.6);
      transition: 0.5s;
      &:hover {
        background: rgba(30, 30, 30, 0.7);
        transition: 0.5s;
      }
    }
  }
</style>
