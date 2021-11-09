<template>
  <div class="relative flex flex-col mb-5">
    <div
      class="flex items-center justify-between bg-gray-700 md:px-10"
    >
      <a
        href="/"
        class="py-1 pl-2 cursor-pointer md:my-2 justify-self-center"
      >
        <img
          :src="this.nexcarLogoUrl"
          class="h-6 p-1 md:h-12"
        >
      </a>
      <div
        class="flex justify-end p-2 justify-self-end"
        v-if="!this.$root.isMobile"
      >
        <a
          class="self-center p-2 mr-6 text-lg text-white hover:bg-nexcar-green rounded-xl hover:text-white focus:outline-none"
          :class="{ 'bg-nexcar-green': currentRoute === '/' }"
          href="/"
        >
          ¿Qué es Nexcar?
        </a>
        <a
          class="self-center p-2 mr-6 text-lg text-white hover:bg-nexcar-green rounded-xl hover:text-white focus:outline-none"
          :class="{ 'bg-nexcar-green': currentRoute === '/frequent_questions' }"
          href="/frequent_questions"
        >
          FAQ
        </a>
        <a
          class="self-center p-2 text-lg text-white hover:bg-nexcar-green rounded-xl hover:text-white focus:outline-none"
          :class="{ 'text-white bg-nexcar-green': currentRoute === '/cars' }"
          href="/cars"
        >
          Busca tu Nexcar
        </a>
      </div>
      <img
        v-else
        src="../../../assets/images/icons/header-navegation-icon.svg"
        class="w-6 h-6 mr-2 cursor-pointer"
        @click="showMobileOptions = !showMobileOptions"
      >
    </div>
    <div
      class="absolute right-0 flex flex-col self-end p-2 px-3 mb-4 text-right bg-gray-700 top-full rounded-bl-md"
      v-if="showMobileOptions"
    >
      <a
        href="/"
        class="mb-2 text-sm text-white"
        :class="{ 'text-nexcar-green': currentRoute === '/' }"
      >
        ¿Qué es Nexcar?
      </a>
      <a
        href="/frequent_questions"
        class="mb-2 text-sm text-white"
        :class="{ 'text-nexcar-green': currentRoute === '/frequent_questions' }"
      >
        FAQ
      </a>
      <a
        href="/cars"
        class="text-sm text-white"
        :class="{ 'text-nexcar-green': currentRoute === '/cars' }"
      >
        Busca tu Nexcar
      </a>
    </div>
  </div>
</template>
<script>
export default {
  props: {
    nexcarLogoUrl: { type: String, default: '' },
  },
  data() {
    return {
      showMobileOptions: false,
    };
  },
  computed: {
    currentRoute() {
      return window.location.pathname;
    },
  },
};
</script>
