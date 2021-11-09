export default {
  computed: {
    validEmail() {
      return (/^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/.test(this.email));
    },
  },
};
