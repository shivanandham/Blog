<template>
  <div class="bg">
    <Header />
    <br>
    <div class="mx-auto" style="width: 70rem">
      <!-- <div style="width:56rem;"> -->
      <div v-if="error">{{ error }}</div>
      <!-- <h3>Add a new blog</h3> -->

      <b-card-group style="width: 70rem;">
      <b-card bg-variant="primary" text-variant="white" style="width: 56rem;" >
      <p class="text-xl-left font-weight-bold" style="font-size:30px"> Blogs <b-button pill @click.prevent="addBlog" variant="success" style="float: right;">Add new Blog</b-button></p>
      <!-- <p class="text-right"><b-button pill @click.prevent="addBlog" variant="success">Add new Blog</b-button></p> -->
      <hr>

      <ul>
        <li v-for="blog in blogs" :key="blog.id" :blog="blog">
          <!-- overlay img-src="../../assets/bg.jpg" img-alt="Card Image" -->
          <b-card bg-variant="light" text-variant="white" style="width: 100%;">
            <p><b-link class="text-capitalize font-weight-bold" style="font-size:20px" @click.prevent="showBlog(blog.id)">{{ blog.title }}</b-link>
            <b-button
              pill
              v-on:click.self.prevent="removeBlog(blog.id)"
              variant="outline-danger"
              v-if="checkValidation(blog.user_id)"
              style="float: right;"
              >Delete</b-button
            >
              <b-button
              pill
              v-on:click.self.prevent="editBlog(blog.id)"
              variant="outline-primary"
              v-if="checkValidation(blog.user_id)"
              style="float: right;"
              >Edit</b-button
            ></p>
            <b-card-text class="text-dark text-capitalize">
              {{ blog.body }}
            </b-card-text>

          </b-card>
          <br />
        </li>
      </ul>
      </b-card>
      </b-card-group>
    </div>
  </div>
</template>

<script>
import Header from '@/components/Header.vue'
// import Header from '../Header.vue'
export default {
  name: 'Blogs',
  components: {
    Header
    // Header
  },
  data () {
    return {
      blogs: [],
      newBlog: [],
      error: '',
      editedBlog: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured
        .get('/api/v2/blogs')
        .then(response => {
          this.blogs = response.data
        })
        .catch(error => this.setError(error, 'Something went wrong'))
    }
  },
  methods: {
    setError (error, text) {
      this.error =
        (error.response && error.response.data && error.response.data.error) ||
        text
    },
    addBlog () {
      this.$router.push('/new')
      // const value = this.newBlog
      // if (!value) {
      //   return
      // }
      // this.$http.secured
      //   .post('/api/v2/blogs/', {
      //     blog: { title: this.newBlog.title, body: this.newBlog.body }
      //   })
      //   .then(response => {
      //     this.blogs.push(response.data)
      //     this.newBlog = ''
      //   })
      //   .catch(error => this.setError(error, 'Cannot create blog'))
    },
    removeBlog (blog) {
      this.$http.secured
        .delete(`/api/v2/blogs/${blog}`)
        .then(response => {
          console.log(response)
          this.blogs.splice(this.blogs.indexOf(blog), 1)
        })
        .catch(error => this.setError(error, 'Cannot delete blog'))
    },
    showBlog (blog) {
      this.$router.push('/show/' + blog)
    },
    editBlog (blog) {
      this.$router.push('/edit/' + blog)
    },
    updateBlog (blog) {
      this.editedBlog = ''
      this.$http.secured
        .patch(`/api/v2/blogs/${blog.id}`, {
          blog: { title: blog.title, body: blog.body }
        })
        .catch(error => this.setError(error, 'Cannot update blog'))
    },
    checkValidation (id) {
      // debugger
      if (parseInt(localStorage.userId) === id) {
        return true
      } else {
        return false
      }
    }
  }
}
</script>

<style scoped>
/* .card {
  position: relative;
}

a.stretched-link:before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
}

.second {
  required
  position: relative;
  z-index: 1;
}
.bg{
  background-image: url('../../assets/bg1.jpg');
  background-repeat: no-repeat;
  background-attachment: fixed;
  background-size: cover;
}*/
</style>
