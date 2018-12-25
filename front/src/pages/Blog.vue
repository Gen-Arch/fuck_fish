<template>
  <div id="container">
    <div id="header">
      <span>HEADER</span>
    </div>
    <div id="contents">
      <div id="menu">CONTENT-MENU</div>
      <div id="body">
        <div class="card" v-for="(item, index) in contents" :key="index">
          <div class="card-title">本日はルーアでつれました！</div>
          {{item}}
          <div class="card-body"></div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      contents: [1, 2, 3, 4, 5]
    };
  }
};
</script>
<style lang="scss" scoped>
#container {
  margin: 0;
  min-height: 100vh;
  height: 100vh;
  width: 100%;
  background-image:url('https://mashichan.c.blog.so-net.ne.jp/_images/blog/_751/mashichan/IMG_1561-d3387.jpg');
  background-size: cover;
  color: white;
  display: flex;
  flex-direction: column;
}
#header {
  display: flex;
  justify-content: center;
  border: solid 1px rgb(200, 200, 200);
}
#contents {
  display: flex;
  height: 100%;
  #menu {
    border: solid 1px;
    flex-grow: 0.5;
    height: 90%;
  }
  #body {
    border: solid 1px;
    flex-grow: 2;
    height: 90%;
    .card {
      font-size: 16px;
      background: rgba(30, 30,30,0.3);
      margin: 10px;
      padding: 5px;
      box-shadow:2px 2px 2px 2px rgba(73, 73, 73, 0.6);
      &:hover{
        background: rgba(30, 30,30,0.7);
      }
    }
  }
}
</style>
