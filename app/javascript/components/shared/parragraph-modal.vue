<template>
  <div
    class="flex flex-col p-2 font-main"
    :class="modalClases"
  >
    <button
      class="self-end mb-2 focus:outline-none"
      @click="closeModal"
    >
      <img
        class="w-4 h-4 md:w-6 md:h-6"
        :src="require('assets/images/close.svg')"
      >
    </button>
    <p
      class="text-gray-700"
      :class="messageClases"
    >
      {{ message }}
    </p>
  </div>
</template>
<script>
export default {
  props: {
    message: { type: String, default: '' },
    messageClases: { type: String, default: '' },
    modalClases: { type: String, default: '' },
  },
  methods: {
    closeModal() {
      this.$modal.hide('paragraph-modal');
    },
  },
};
</script>
