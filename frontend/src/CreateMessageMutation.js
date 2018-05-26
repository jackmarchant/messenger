import { graphql, commitMutation } from 'react-relay';
import modernEnvironment from './environment';
import { ConnectionHandler } from 'relay-runtime';

const mutation = graphql`
  mutation CreateMessageMutation($input: CreateMessageInput!) {
    createMessage(input: $input) {
      message {
        content
      }
    }
  }
`;

let tempID = 0;
export default {
  commit: (inputVariables, config = {}) => {
    return new Promise((resolve, reject) => {
      const { userId, threadId, content } = inputVariables;
      commitMutation(modernEnvironment, {
        mutation,
        variables: {
          input: {
            userId,
            threadId,
            content, 
            clientMutationId: `createThread${tempID++}`,
          },
        },
        onCompleted: response => resolve(response),
        onError: error => reject(error),
      });
    });
  },
};