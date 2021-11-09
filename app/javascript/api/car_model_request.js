import api from './index';

export default {
  create(body) {
    return api({
      method: 'post',
      url: '/api/v1/car_model_requests',
      data: { 'carModelRequest': body },
    });
  },
};
