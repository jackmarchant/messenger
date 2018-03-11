const { Environment, Network, RecordSource, Store } = require('relay-runtime');

const recordSource = new RecordSource();
const store = new Store(recordSource);

const network = Network.create((operation, variables) => {
  // eslint-disable-next-line compat/compat
  return fetch('/graphql', {
    method: 'POST',
    headers: {
      Accept: 'application/json',
      'Content-Type': 'application/json',
    },
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