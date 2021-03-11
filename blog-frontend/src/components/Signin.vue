<template>
  <div>
    <div class="border p-10 border-grey-light shadow rounded">
      <h3 class="text-2xl mb-6 text-grey-darkest">Sign In</h3>
      <b-form @submit.prevent="signin">
        <div class="text-red" v-if="error">{{ error }}</div>

        <!-- <div class="mb-6">
          <label for="email" class="label">E-mail Address</label>
          <input type="email" v-model="email" class="input" id="email" placeholder="example@example.com">
        </div> -->

        <b-form-group label="Username" label-for="email">
          <b-form-input id="email" v-model="email" type="email" placeholder="Enter Email Address" required></b-form-input>
        </b-form-group>

        <b-form-group label="Password" label-for="password">
          <b-form-input id="password" v-model="password" type="password" placeholder="Password" required></b-form-input>
        </b-form-group>

        <!-- <div class="mb-6">
          <label for="password" class="label">Password</label>
          <input type="password" v-model="password" class="input" id="password" placeholder="Password">
        </div> -->
        <!-- <button type="submit" class="font-sans font-bold px-4 rounded cursor-pointer no-underline bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center">Sign In</button> -->
        <b-button type="submit" variant="primary" >Sign In</b-button>

        <b-link to="/signup" class="link-grey" variant="outline-primary">Sign up</b-link>
      </b-form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Signin',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain.post('/signin', { email: this.email, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      // debugger
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      // console.log(typeof(userId))
      // console.log(typeof(response.data.userId.id))
      localStorage.userId = response.data.userId.id
      localStorage.signedIn = true

      this.$store.commit('setUser', {
        token: true
      })
      this.error = ''
      this.$router.replace('/blogs')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
      delete localStorage.userId
      this.$store.commit('setUser', {
        token: false
      })
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/blogs')
      }
    }
  }
}
</script>
