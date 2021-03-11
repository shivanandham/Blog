<template>
<div>
  <Header />
  <div class="max-w-md m-auto py-10">
    <div class="text-red" v-if="error">{{ error }}</div>
    <h3 class="font-mono font-regular text-3xl mb-4">Add New Blog</h3>
    <form action="" @submit.prevent="addBlog">
      <!-- <div class="mb-6">
        <input class="input"
          autofocus autocomplete="off"
          placeholder="Title"
          v-model="newBlog.title" />

      </div> -->
      <b-form-group id="title" label="Title" label-for="title">
        <b-form-input
          id="title"
          v-model="newBlog.title"
          placeholder="Enter Title"
          required
        ></b-form-input>
      </b-form-group>

      <b-form-group id="body" label="Body" label-for="body">
        <b-textarea
          id="bodyy"
          v-model="newBlog.body"
          placeholder="Enter Content"
          required
        ></b-textarea>
      </b-form-group>

      <!-- <div class="mb-6">
        <textarea class="input"
          autofocus autocomplete="off"
          placeholder="Body"
          v-model="newBlog.body" />
      </div> -->
      <b-button variant="success" block type="submit" value="Save">Save</b-button>
    </form>
<br>
<b-button variant="outline-primary" @click="back">Back</b-button>
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
      this.$http.secured.post('/api/v2/blogs/', { blog: { title: this.newBlog.title, body: this.newBlog.body } })

        .then(response => {
          this.newBlog = ''
          this.$router.replace('/blogs')
        })
        .catch(error => this.setError(error, 'Cannot create blog'))
    },
    back () {
      this.$router.replace('/blogs')
    }
  }
}
</script>
