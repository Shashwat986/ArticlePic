export default {
  baseUrl: '/api/',
  routes: {
    'document#{num}': {
      path: 'documents/{num}',
      method: 'GET'
    },
    'documents': {
      path: 'documents/',
      method: 'GET'
    }
  }
};
