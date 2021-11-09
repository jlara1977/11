<template>
  <div class="flex flex-col">
    <div class="grid w-full grid-cols-1 mb-20 md:mb-32 md:grid-cols-3 gap-y-8">
      <p class="text-xl font-semibold text-center text-gray-700 md:text-3xl justify-self-center md:row-span-2 md:text-left">
        Preguntas Frecuentes <br>
        <span class="text-base font-normal text-gray-500 md:text-lg">
          ¿Aún tienes dudas? ¡Contáctanos!
        </span>
      </p>
      <div
        class="border rounded-md shadow-md md:col-start-2 md:col-span-2"
        v-for="category in categoriesOptions"
        :key="category.key"
      >
        <div
          class="flex items-center justify-between px-4 py-3 rounded-lg cursor-pointer"
          :class="{ 'hover:bg-nexcar-second-light-green': !categoriesOpen[category.key],
                    'mb-2': categoriesOpen[category.key] }"
          @click="changeCategoryOpenStatus(category.key)"
        >
          <p
            class="text-lg md:text-gray-700"
          >
            {{ category.value }}
          </p>
          <img
            src="../../../assets/images/icons/plus-icon.svg"
            class="w-4 h-4 mr-6"
            v-if="!categoriesOpen[category.key]"
          >
          <img
            src="../../../assets/images/icons/minus-icon.svg"
            class="w-4 h-4 mr-6"
            v-else
          >
        </div>
        <div
          v-if="categoriesOpen[category.key]"
          class="px-6 pt-2"
        >
          <div
            class="mb-4"
            v-for="frequentQuestion in filterFrequentQuestions(category.key)"
            :key="frequentQuestion.id"
          >
            <div
              class="flex items-center justify-between px-4 py-3 rounded-lg cursor-pointer bg-nexcar-second-light-green"
              :class="{ 'mb-2': frequentQuestionsOpen[frequentQuestion.id] }"
              @click="changeOpenStatus(frequentQuestion.id)"
            >
              <p
                class="text-lg md:text-xl text-nexcar-dark-green"
              >
                {{ frequentQuestion.question }}
              </p>
              <img
                src="../../../assets/images/icons/down-arrow-icon.svg"
                class="w-4 h-4"
                :class="{
                  'rotate-180 transition-transform duration-500 transform': frequentQuestionsOpen[frequentQuestion.id],
                }"
              >
            </div>
            <p
              class="px-4 text-gray-400 text-md md:text-lg"
              v-if="frequentQuestionsOpen[frequentQuestion.id]"
              v-html="frequentQuestion.answer"
            />
          </div>
        </div>
      </div>
    </div>
    <find-your-nexcar />
  </div>
</template>
<script>
import FindYourNexcar from '../shared/find-your-nexcar.vue';

export default {
  components: {
    FindYourNexcar,
  },
  props: {
    frequentQuestions: { type: Array, default() { return []; } },
    categoriesOptions: { type: Array, default() { return []; } },
  },
  data() {
    return {
      categoriesOpen: this.categoriesOptions.reduce((allObjects, category) => (
        { ...allObjects, ...{ [category.key]: false } }
      ), {}),
      frequentQuestionsOpen: this.frequentQuestions.reduce((allObjects, frequentQuestion) => (
        { ...allObjects, ...{ [frequentQuestion.id]: false } }
      ), {}),
    };
  },
  methods: {
    changeOpenStatus(frequentQuestionId) {
      this.frequentQuestionsOpen[frequentQuestionId] = !this.frequentQuestionsOpen[frequentQuestionId];
    },
    changeCategoryOpenStatus(categoryKey) {
      this.categoriesOpen[categoryKey] = !this.categoriesOpen[categoryKey];
    },
    filterFrequentQuestions(categoryKey) {
      return this.frequentQuestions.filter((frequentQuestion) => frequentQuestion.category === categoryKey);
    },
  },
};
</script>
