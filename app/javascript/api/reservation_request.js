import api from './index';

export default {
  createReservationRequest(body) {
    return api({
      method: 'post',
      url: '/api/v1/reservation_requests',
      data: { 'reservationRequest': body },
    });
  },
};
