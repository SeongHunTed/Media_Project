<template>
    <div>
        <h1 id="nav-font">회원가입</h1>
        <hr>
        <div class="d-flex flex-column">
            <form @submit.prevent="signUp">
                <label for="username">USERNAME : </label>
                <input type="text" id="username" v-model="username">
                <hr>
                <label for="password1">비밀번호 : </label>
                <input type="password" id="password1" v-model="password1">
                <hr>
                <label for="password2">비밀번호 확인 : </label>
                <input type="password" id="password2" v-model="password2">
                <hr>
                <input class="btn btn-secondary" type="submit" value="회원가입">
            </form>
            <router-link :to="{ name: 'LogInView' }"><button class="btn btn-primary">로그인</button></router-link>
    </div>
    </div>
</template>

<script>
export default {
    name: 'SignUpView',
    data() {
        return {
            username: '',
            password1: '',
            password2: '',
        }
    }
    ,
    methods: {
        signUp() {
            const username = this.username
            const password1 = this.password1
            const password2 = this.password2

            const payload = {
                username,
                password1,
                password2
            }
            this.$store.dispatch('signUp', payload)
        }
    }
}
</script>

<style>

</style>