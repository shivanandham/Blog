<template>
  <div>
    <Header />
    <div class="max-w-md m-auto py-10">
      <div class="text-red" v-if="error">{{ error }}</div>
      <h3 class="font-mono font-regular text-3xl mb-4">Edit Blog</h3>
      <b-form action="" @submit.prevent="addBlog">
        <b-form-group class="mb-6">
          <b-form-input
            class="input"
            autofocus
            autocomplete="off"
            placeholder="Title"
            v-model="newBlog.title"
          />
        </b-form-group>
        <b-form-group class="mb-6">
          <b-form-textarea
            class="input"
            autofocus
            autocomplete="off"
            placeholder="Body"
            v-model="newBlog.body"
          />
        </b-form-group>
        <b-button
          type="submit"
          variant="success"
          block
        >Update</b-button>
      </b-form>
      <br />
      <b-button  variant="outline-primary" @click="back">Back</b-button>
    </div>
  </div>
</template>

<script>
import Header from '@/components/Header.vue'
export default {
  name: 'Blogs',
  components: {
    Header
  },
  data () {
    return {
      newBlog: [],
      error: ''
    }
  },
  created () {
    if (!localStorage.signedIn) {
      this.$router.replace('/')
    } else {
      // debugger
      this.$http.secured.get('/api/v2/blogs/' + this.$route.params.id)
        .then((response) => {
          this.newBlog = response.data
          console.log(this.blog)
        })
        .catch(function (error) {
          console.log(error)
        })
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    addBlog () {
      const value = this.newBlog
      if (!value) {
        return
      }

      this.$http.secured.patch(`/api/v2/blogs/${this.$route.params.id}`, { blog: { title: this.newBlog.title, body: this.newBlog.body } })

        .then(response => {
          console.log(response)
          this.newBlog = ''
          this.$router.replace('/blogs')
        })
        .catch(error => this.setError(error, 'Cannot create Blog'))
    },
    back () {
      this.$router.replace('/blogs')
    }
  }
}
</script>
