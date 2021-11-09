<template>
  <div class="flex flex-col py-5 pr-2 mx-2 my-6 bg-white border rounded-md shadow pl-7 md:mx-4 lg:rounded-lg">
    <p class="mb-1 font-medium text-gray-700">
      {{ this.carReviewer }} <br>
      <span class="text-sm text-gray-400">
        {{ this.carModel }} - {{ this.date }}
      </span>
    </p>
    <div class="flex mb-4">
      <img
        src="../../../assets/images/icons/start-icon.svg"
        class="w-3 h-3 mr-2"
        v-for="i in 5"
        :key="i"
      >
    </div>
    <p class="text-sm text-gray-700">
      {{ this.comment ||
        'Muy fácil, rápido a precio razonalble y los únicos que aceptan transferencia bancarias. 100% Recomendaso.' }}
    </p>
  </div>
</template>
<script>
export default {
  props: {
    carModel: { type: String, default: 'Opel Grandland X' },
    carEdition: { type: String, default: 'Edition 1.6T' },
    carReviewer: { type: String, default: 'Agustín Feuerhake' },
    date: { type: String, default: '11 de Febrero 2021' },
    comment: { type: String, default: '' },
  },
};
</script>
