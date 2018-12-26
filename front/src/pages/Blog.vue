<template>
  <div id="container">
    <div id="header">
      <span>釣りバカ日誌</span>
    </div>
    <div id="contents">
      <div id="menu">
        <div class="acc">
          <label for="label1">日記</label>
          <input type="checkbox" id="label1" class="acc_title">
          <div class="acc_content">
            <ul>
              <li>
                <router-link to="/">閲覧</router-link>
              </li>
              <li>
                <router-link to="/post">投稿</router-link>
              </li>
            </ul>
          </div>
        </div>
        <div class="acc">
          <label for="label2" class="acc">ツール各種</label>
          <input type="checkbox" id="label2" class="acc_title">
          <div class="acc_content">
            <ul>
              <li>潮時表</li>
              <li>釣果MAP</li>
            </ul>
          </div>
        </div>
      </div>
      <router-view />
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
  background-image: url("../../images/gen.jpg");
  background-size: cover;
  color: white;
  display: flex;
  flex-direction: column;
}
#header {
  font-size: 32px;
  color: rgb(73, 73, 73);
  filter: drop-shadow(10px 10px 5px rgba(10, 10, 10, 0.6));
  display: flex;
  justify-content: center;
  align-items: center;
  height: 10%;
}
#contents {
  display: flex;
  background-color: rgba(73, 73, 73, 0.6);
  box-shadow: 5px 5px 5px rgba(10, 10, 10, 0.5);
  height: 100%;
  margin: 10px;

  #menu {
    border-right: solid 1px;
    flex-grow: 0.5;
    height: 100%;
    & input {
      display: none;
    }
    .acc label {
      display: block;
      background: rgba(30, 30, 30, 0.6);
      margin: 5px;
      &:hover {
        background: rgba(10, 10, 10, 0.6);
      }
    }
    .acc_title:checked + .acc_content {
      height: auto;
      padding: 15px;
      opacity: 1;
    }
    .acc_content {
      height: 0;
      padding: 0;
      overflow: hidden;
      opacity: 0;
      transition: 0.8s;
      & ul {
        list-style: none;
        margin: 0;
        padding: 0;
        & li {
          margin: 5px 0;
          border-bottom: 1px solid;
          transition: 0.3s;
          &:hover {
            transition: 0.3s;
            background: rgba(10, 10, 10, 0.6);
          }
        }
      }
    }
  }

}
</style>
