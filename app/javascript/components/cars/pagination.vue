<template>
  <div class="flex items-center justify-center w-full mb-4 text-base text-gray-700">
    <button
      class="flex px-2 py-1 text-gray-400 focus:outline-none"
      :class="{'hover:text-gray-600': firstPageRange[0] !== actualPage,
               'cursor-default': firstPageRange[0] == actualPage}"
      @click="changePage(false)"
    >
      <img
        src="../../../assets/images/icons/previous-arrow-icon.svg"
        class="mr-2"
      >
      Anterior
    </button>
    <div class="flex">
      <button
        v-for="(index) in firstPageRange"
        :key="`first-${index}`"
        class="px-2 py-1 text-gray-400 hover:text-gray-600 focus:outline-none"
        :class="{ 'text-gray-600': actualPage === index }"
        @click="setNewPage(index)"
      >
        {{ index + 1 }}
      </button>
    </div>

    <div
      class="self-end mx-1 text-gray-400"
      v-if="firstDotsCondition()"
    >
      ...
    </div>
    <button
      class="px-2 py-1 text-gray-600 focus:outline-none"
      v-if="pageOptions <= actualPage && actualPage < pageCount - pageOptions"
    >
      {{ this.actualPage + 1 }}
    </button>
    <div
      class="self-end mx-1 text-gray-400 segundo"
      v-if="lastDotsCondition()"
    >
      ...
    </div>
    <div
      class="flex"
      v-if="pageCount + 1 > 1 && pageCount >= pageOptions * 2"
    >
      <button
        v-for="(index) in lastPageRange"
        :key="`last-${index}`"
        class="px-2 py-1 text-gray-400 hover:text-gray-600 focus:outline-none"
        :class="{ 'text-gray-600': actualPage === index }"
        @click="setNewPage(index)"
      >
        {{ index + 1 }}
      </button>
    </div>
    <button
      class="flex px-2 py-1 text-gray-400 focus:outline-none"
      :class="{'hover:text-gray-600': lastPageRange[lastPageRange.length - 1] !== actualPage,
               'cursor-default': lastPageRange[lastPageRange.length - 1] == actualPage}"
      @click="changePage(true)"
    >
      Siguiente
      <img
        src="../../../assets/images/icons/next-arrow-icon.svg"
        class="ml-2"
      >
    </button>
  </div>
</template>
<script>
import { range } from 'lodash';

const RESOURCES_PER_PAGE = 20;
const PAGE_OPTIONS = 2;
const DOBLE_SIZE = 2;

export default {
  props: {
    resourcesPerPage: {
      type: Number,
      default: RESOURCES_PER_PAGE,
    },
    pageOptions: {
      type: Number,
      default: PAGE_OPTIONS,
    },
    actualPage: {
      type: Number,
      default: 0,
    },
    resourcesLength: {
      type: Number,
      require: true,
      default: 0,
    },
  },
  computed: {
    firstPageRange() {
      return this.rangePageCount.slice(0, this.pageOptions);
    },
    lastPageRange() {
      return this.rangePageCount.slice(- this.pageOptions);
    },
    rangePageCount() {
      return range(this.pageCount);
    },
    pageCount() {
      return Math.ceil(this.resourcesLength / this.resourcesPerPage);
    },
  },
  methods: {
    firstDotsCondition() {
      return this.pageCount > this.pageOptions * DOBLE_SIZE &&
        this.actualPage < this.lastPageRange[0] &&
        this.firstPageRange[this.firstPageRange.length - 1] + 1 !== this.lastPageRange[0] &&
        this.firstPageRange[this.firstPageRange.length - 1] + 1 !== this.actualPage;
    },
    lastDotsCondition() {
      return this.pageCount > this.pageOptions * DOBLE_SIZE &&
        this.firstPageRange[this.firstPageRange.length - 1] < this.actualPage &&
        this.lastPageRange[0] - 1 !== this.lastPageRange[0] &&
        this.lastPageRange[0] - 1 !== this.actualPage;
    },
    changePage(increment) {
      if (increment && this.actualPage + 1 !== this.pageCount) {
        this.emitChangePage(this.actualPage + 1);
      }
      if (!increment && this.actualPage !== 0) {
        this.emitChangePage(this.actualPage - 1);
      }
    },
    setNewPage(pageNumber) {
      this.emitChangePage(pageNumber);
    },
    emitChangePage(newPageValue) {
      this.$emit('set-new-page-index', newPageValue);
    },
  },
};
</script>
