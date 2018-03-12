import { graphql, commitMutation } from 'react-relay';
import modernEnvironment from './environment';
// import { ConnectionHandler } from 'relay-runtime';

const mutation = graphql`
  mutation CreateThreadMutation($input: CreateThreadInput!) {
    createThread(input: $input) {
      thread {
        slug
      }
    }
  }
`;

let tempID = 0;
export default {
  commit: (inputVariables, config = {}) => {
    return new Promise((resolve, reject) => {
      const { userId, name, participants } = inputVariables;
      commitMutation(modernEnvironment, {
        mutation,
        variables: {
          input: {
            userId,
            name,
            participants, 
            clientMutationId: `createThread${tempID++}`,
          },
        },
        onCompleted: response => resolve(response),
        onError: error => reject(error),
        // updater: store => {
        //   const payload = store.getRootField('createThread');
        //   const newEdge = payload.getLinkedRecord('thread');

        //   const proxy = store.getRoot();
        //   const conn = ConnectionHandler.getConnection(
        //     proxy,
        //     'ThreadList_threadsUnlisted'
        //   );
        //   ConnectionHandler.insertEdgeBefore(conn, newEdge);
        // },
      });
    });
  },
};