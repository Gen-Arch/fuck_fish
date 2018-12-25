<template>
  <div>
    <span class="ms">{{message}}</span>
  </div>
</template>
<script>
export default {
  data() {
    return {
      message: "hello vue."
    }
  }
};
</script>
<style lang="scss" scoped>
  .ms{
    color: blue;
    font-size: 40px;
  }
</style>
