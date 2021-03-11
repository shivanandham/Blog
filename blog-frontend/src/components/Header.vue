<template>
  <!-- <header class="bg-grey-lighter py-4" >
    <div class="container mx-auto flex flex-wrap items-center justify-end" >
      <div class="flex-1 flex items-center">
        <title> Blogs</title>
        <a href="/" class="uppercase text-sm font-mono pl-4 font-semibold no-underline text-indigo-dark hover:text-indigo-darker">Blogs</a>
      </div>
      <div>
        <router-link to="/" class="link-grey px-2 no-underline" v-if="!signedIn()">Sign in</router-link>
        <router-link to="/signup" class="link-grey px-2 no-underline" v-if="!signedIn()">Sign Up</router-link>
        <router-link to="/blogs" class="link-grey px-2 no-underline" v-if="signedIn()">Blogs</router-link>
        <a href="#" @click.prevent="signOut" class="link-grey px-2 no-underline" v-if="signedIn()">Sign out</a>
      </div>
    </div>
  </header> -->

  <div>
    <b-navbar toggleable="lg" type="dark" variant=dark position="sticky">
      <b-navbar-brand href="/">Blogs</b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>

        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <router-link to="/" class="link-grey px-2 no-underline" v-if="!signedIn()">Sign in</router-link>
          <router-link to="/signup" class="link-grey px-2 no-underline" v-if="!signedIn()">Sign Up</router-link>
          <b-nav-item href="/" @click.prevent="signOut" class="" v-if="signedIn()">Sign out</b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </div>
</template>

<script>
export default {
  name: 'Header',
  created () {
    this.signedIn()
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>
