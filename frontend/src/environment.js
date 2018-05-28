const { Environment, Network, RecordSource, Store } = require('relay-runtime');

const recordSource = new RecordSource();
const store = new Store(recordSource);

const network = Network.create((operation, variables) => {
  const sessionToken = window.localStorage.getItem('SessionToken');
  const headers = {
    Accept: 'application/json',
    'Content-Type': 'application/json',
  };
  if (sessionToken) {
    headers['Authorization'] = `Bearer ${sessionToken}`;
  }
  // eslint-disable-next-line compat/compat
  return fetch('/graphql', {
    method: 'POST',
    headers: headers,
    credentials: 'same-origin',
    body: JSON.stringify({
      query: operation.text,
      variables,
    }),
  }).then(response => {
    return response.json();
  });
});

const environment = new Environment({
  network,
  store,
});

export { store, network, recordSource };
export default environment;