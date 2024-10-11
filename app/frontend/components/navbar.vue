<script setup lang="ts">

import {defineProps} from 'vue'
import UserType from "~/types/UserType";

const props = defineProps<{
  user: UserType
}>()
</script>

<template>
  <p>navbar</p>
  <p> {{ props.user.id }} </p>

</template>

<style scoped>

</style>