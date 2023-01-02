<template>
    <div id="test">
        <h1>{{ message }}</h1>
    </div>
</template>

<script>
    export default {
        name: 'test_1' ,
        computed: {
            message() {
                return this.$store.state.username
            },
        },
    }
</script>