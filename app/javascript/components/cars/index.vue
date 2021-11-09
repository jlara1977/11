<template>
  <div
    class="grid grid-cols-1 md:grid-cols-12 gap-x-9"
    :class="{ 'mx-4': isMobile }"
  >
    <filters
      v-show="!isMobile || this.showFilters"
      :car-list="carList"
      :brands="brands"
      :models="models"
      :shift-options="shiftOptions"
      :fuel-options="fuelOptions"
      :traction-options="tractionOptions"
      :filter-brand="filterBrand"
      :car-type-options="carTypeOptions"
      @set-filter-models="updateFilterModelList($event)"
      @set-show-filters="changeFiltersStatus()"
    />
    <div class="flex flex-col mb-4 md:col-span-8 lg:col-span-9">
      <div class="flex col-span-2 px-2 mb-4 border border-gray-300 rounded-md md:col-span-3">
        <img
          src="../../../assets/images/search-icon.svg"
          class="self-center w-5 h-5"
        >
        <input
          class="w-full p-2 py-3 mr-4 text-gray-400 md:mr-0 focus:outline-none max-h-12"
          placeholder="Buscar"
          type="text"
          v-model="searchText"
        >
        <button
          class="mr-2 focus:outline-none"
          v-if="isMobile"
          @click="changeFiltersStatus()"
        >
          <img
            class="w-12 h-auto"
            src="../../../assets/images/filter.svg"
          >
        </button>
      </div>
      <create-model-request
        v-if="emptySearch"
        :annual-distance-options="annualDistanceOptions"
        :contract-time-options="contractTimeOptions"
        @change-request-car-model="changeRequestCarModel()"
      />
      <div
        class="grid grid-cols-2 col-span-2 lg:grid-cols-3 md:col-span-3 gap-x-9 gap-y-7"
        v-else
      >
        <div class="col-span-2 md:col-span-1 lg:col-span-2">
          <p>
            ¿No encuentras tu auto favorito?
          </p>
          <a
            class="cursor-pointer text-nexcar-green"
            @click="changeRequestCarModel"
          >
            ¡Pídelo Aquí!
          </a>
        </div>
        <div class="flex w-full col-span-2 md:mr-2 md:col-span-1 md:w-44 justify-self-end">
          <nexcar-multiselect
            v-model="selectedOrderBy"
            :options="orderByOptions"
            v-bind="multiselectProps"
            label="name"
            track-by="key"
            @input="changeSortBy"
          />
        </div>
        <div class="flex col-span-2 h-28 lg:h-20 md:col-span-2 lg:col-span-3">
          <div class="w-2 h-full rounded-l-md bg-nexcar-green" />
          <div class="flex flex-col justify-around w-full px-3 pt-2 pb-3 border-2 border-l-0 border-gray-200 rounded-md rounded-l-none">
            <p class="text-sm md:text-base">
              Todos nuestros autos incluyen:
            </p>
            <div class="grid grid-cols-2 text-xs lg:flex lg:flex-wrap lg:justify-between md:text-sm md:mb-3">
              <div class="flex items-center mr-2">
                <img
                  src="../../../assets/images/icons/included-ticket.svg"
                  class="mr-2"
                >
                <p class="text-nexcar-green">
                  Mantención
                </p>
              </div>
              <div class="flex items-center mr-2">
                <img
                  src="../../../assets/images/icons/included-ticket.svg"
                  class="mr-2"
                >
                <p class="text-nexcar-green">
                  Seguros
                </p>
              </div>
              <div class="flex items-center mr-2">
                <img
                  src="../../../assets/images/icons/included-ticket.svg"
                  class="mr-2"
                >
                <p class="text-nexcar-green">
                  Patentes e Impuestos
                </p>
              </div>
              <div class="flex items-center mr-2">
                <img
                  src="../../../assets/images/icons/included-ticket.svg"
                  class="mr-2"
                >
                <p class="text-nexcar-green">
                  Entrega a domicilio
                </p>
              </div>
              <div class="flex items-center mr-2">
                <img
                  src="../../../assets/images/icons/included-ticket.svg"
                  class="mr-2"
                >
                <p class="text-nexcar-green">
                  Y más
                </p>
              </div>
            </div>
          </div>
        </div>
        <div
          class="flex flex-col col-span-2 px-6 shadow cursor-pointer rounded-3xl bg-nexcar-second-light-green bg-opacity-30 md:col-span-1 py-7"
          v-for="(model) in paginatedFilterModelList"
          :key="model.id"
          :onclick="`window.location='/models/${model.id}';`"
        >
          <img
            :src="model.mainImageUrl"
            class="object-scale-down h-48 mb-4 bg-white"
          >
          <div class="flex justify-between text-gray-400">
            <p class="mb-2 text-xl font-medium">
              {{ model.brandName }}
            </p>
            <p>
              {{ model.carType }}
            </p>
          </div>
          <a class="mb-2 text-3xl text-nexcar-black">{{ model.name }}</a>
          <div class="flex items-center justify-between">
            <feature-icons :model="model" />
            <div class="flex flex-col text-right xl:justify-self-end md:-mr-2 xl:-mr-0">
              <p class="self-start text-sm text-gray-400 xl:text-base">
                Desde:
              </p>
              <p class="text-xl xl:text-2xl text-nexcar-green">
                {{ model.formattedMinimumPrice }}
              </p>
              <p class="self-end text-sm xl:text-base text-nexcar-green">
                mensuales
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <pagination
      v-if="!emptySearch"
      class="flex justify-center md:col-start-4 md:col-span-9"
      :resources-per-page="resourcesPerPage"
      :page-options="pageOptions"
      :actual-page="actualPage"
      :resources-length="filterModelList.length"
      @set-new-page-index="actualPage = $event"
    />
  </div>
</template>
<script>
import Filters from './filters';
import Pagination from './pagination';
import CreateModelRequest from '../car_model_requests/create';
import FeatureIcons from '../models/feature-icons.vue';

const RESOURCES_PER_PAGE = 9;
const PAGE_OPTIONS = 2;

export default {
  components: {
    Filters,
    Pagination,
    CreateModelRequest,
    FeatureIcons,
  },
  props: {
    carList: { type: Array, require: true, default() { return []; } },
    brands: { type: Array, require: true, default() { return []; } },
    models: { type: Array, require: true, default() { return []; } },
    shiftOptions: { type: Array, require: true, default() { return []; } },
    fuelOptions: { type: Array, require: true, default() { return []; } },
    tractionOptions: { type: Array, require: true, default() { return []; } },
    annualDistanceOptions: { type: Array, require: true, default() { return []; } },
    contractTimeOptions: { type: Array, require: true, default() { return []; } },
    carTypeOptions: { type: Array, require: true, default() { return []; } },
    filterBrand: { type: Object, default() { return null; } },
  },
  data() {
    const customPrioritizedModels = this.setPrioritizedModelsFirst(this.models);

    return {
      filterCarList: this.carList,
      filterModelList: customPrioritizedModels,
      filterModelListCopy: customPrioritizedModels,
      actualPage: 0,
      resourcesPerPage: RESOURCES_PER_PAGE,
      pageOptions: PAGE_OPTIONS,
      showFilters: false,
      searchText: '',
      requestCarModel: false,
      sortedByMinimumPrice: true,
      selectedOrderBy: [],
    };
  },
  computed: {
    emptySearch() {
      return this.filterModelList.length === 0 || this.requestCarModel;
    },
    isMobile() {
      return this.$root.isMobile;
    },
    paginatedFilterModelList() {
      return this.filterModelList.slice(
        this.actualPage * RESOURCES_PER_PAGE, (this.actualPage + 1) * RESOURCES_PER_PAGE,
      );
    },
    multiselectProps() {
      return {
        multiple: false,
        closeOnSelect: true,
        clearOnSelect: false,
        preserveSearch: true,
        searchable: true,
        placeholder: 'Ordenar Por',
      };
    },
    orderByOptions() {
      return [{ key: 'asc', name: 'Menor Precio' }, { key: 'desc', name: 'Mayor Precio' }];
    },
  },
  methods: {
    setPrioritizedModelsFirst(modelsArray) {
      const customPrioritizedModels = modelsArray.filter((model) => !model.prioritizedDisplay);
      const prioritizedModels = modelsArray.filter((model) => model.prioritizedDisplay).reverse();
      prioritizedModels.forEach((model) => customPrioritizedModels.unshift(model));

      return customPrioritizedModels;
    },
    changeSortBy() {
      if (this.selectedOrderBy && this.selectedOrderBy.key === 'asc') {
        if (!this.sortedByMinimumPrice) {
          this.filterModelList = this.filterModelList.reverse();
          this.sortedByMinimumPrice = true;
        }
      } else if (this.selectedOrderBy) {
        if (this.sortedByMinimumPrice) {
          this.filterModelList = this.filterModelList.reverse();
          this.sortedByMinimumPrice = false;
        }
      }
    },
    changeRequestCarModel() {
      this.requestCarModel = !this.requestCarModel;
    },
    updateFilterModelList(newValue) {
      const customPrioritizedFilterModels = this.setPrioritizedModelsFirst(newValue);
      this.filterModelList = customPrioritizedFilterModels;
      this.filterModelListCopy = customPrioritizedFilterModels;
    },
    changeFiltersStatus() {
      this.showFilters = !this.showFilters;
    },
  },
  watch: {
    filterModelList() {
      this.actualPage = 0;
    },
    searchText() {
      if (this.searchText.length === 0) {
        this.filterModelList = this.filterModelListCopy;
      } else {
        const option = this.searchText.toLowerCase();
        this.filterModelList = this.filterModelListCopy.filter((model) => (
          (model.brandName.toLowerCase().includes(option) ||
          model.name.toLowerCase().includes(option))
        ));
      }
    },
  },
};
</script>
<style>
.left-border-nexcar-green {
  border-left-color: theme('colors.nexcar-green');
}
</style>

