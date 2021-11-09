import 'vue-multiselect/dist/vue-multiselect.min.css';
import Vue from 'vue/dist/vue.esm';
import Multiselect from 'vue-multiselect';
import VModal from 'vue-js-modal';
import VTooltip from 'v-tooltip';
import VueCarousel from 'vue-carousel';
import { camelizeKeys } from 'humps';
import '../css/application.css';

import Cars from '../components/cars/index';
import Model from '../components/models/show';
import FieldMissing from '../components/shared/field-missing';
import Landing from '../components/landing/index';
import AppHeader from '../components/layouts/header';
import AppFooter from '../components/layouts/footer';
import FrequentQuestions from '../components/frequent_questions/index';
import NexcarMultiselect from '../components/shared/nexcar-multiselect';
import currency from '../filters/currency';

// eslint-disable-next-line max-statements
document.addEventListener('DOMContentLoaded', () => {
  Vue.filter('camelizeKeys', camelizeKeys);
  Vue.filter('currency', currency);
  Vue.component('Multiselect', Multiselect);
  Vue.component('NexcarMultiselect', NexcarMultiselect);
  Vue.component('AppHeader', AppHeader);
  Vue.component('AppFooter', AppFooter);
  Vue.use(VModal, { dynamic: true, injectModalsContainer: true });
  Vue.use(VTooltip);
  Vue.use(VueCarousel);

  const MD_SCREEN = 768;
  const LG_SCREEN = 1024;
  const XL_SCREEN = 1280;

  const app = new Vue({
    el: '#vue-app',
    components: {
      Cars,
      Model,
      FieldMissing,
      Landing,
      FrequentQuestions,
    },
    data() {
      return {
        mdScreen: MD_SCREEN,
        lgScreen: LG_SCREEN,
        xlScreen: XL_SCREEN,
        isMobile: window.innerWidth <= MD_SCREEN,
        isMedium: window.innerWidth <= LG_SCREEN,
        isLarge: window.innerWidth <= XL_SCREEN,
      };
    },
    computed: {
      screenBetweenMobileAndLG() {
        return window.innerWidth <= this.lgScreen;
      },
    },
    beforeMount() {
      this.setNewSizes();
      this.$nextTick().then(() => {
        window.addEventListener('resize', this.setNewSizes);
      });
    },
    methods: {
      setNewSizes() {
        this.setIsMobile();
        this.setIsMedium();
        this.setIsLarge();
      },
      setIsMobile() {
        this.isMobile = window.innerWidth <= MD_SCREEN;
      },
      setIsMedium() {
        this.isMedium = window.innerWidth <= LG_SCREEN;
      },
      setIsLarge() {
        this.isLarge = window.innerWidth <= XL_SCREEN;
      },
    },
  });

  return app;
});
