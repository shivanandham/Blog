import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin.vue'
import Signup from '@/components/Signup.vue'
import Blogs from '@/components/blogs/BlogList.vue'
import BlogEdit from '@/components/blogs/BlogEdit.vue'
import BlogNew from '@/components/blogs/BlogNew.vue'
import BlogShow from '@/components/blogs/BlogShow.vue'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/blogs',
      name: 'Blogs',
      component: Blogs
    },
    {
      path: '/',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/edit/:id',
      name: 'BlogEdit',
      component: BlogEdit
    },
    {
      path: '/new',
      name: 'BlogNew',
      component: BlogNew
    },
    {
      path: '/show/:id',
      name: 'BlogShow',
      component: BlogShow
    }
  ]
})
