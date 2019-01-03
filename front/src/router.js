import Vue from 'vue';
import VueRouter from 'vue-router';

import Blog from './pages/Blog.vue';
import Index from './pages/Index.vue';
import Post from './pages/Post.vue';

Vue.use(VueRouter);

var router = new VueRouter({
  routes: [
    {
      path: '/',
      component: Index
    },
    {
      path: '/post',
      component: Post
    }
  ]
});

export default router;
