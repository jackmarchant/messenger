import { graphql, commitMutation } from 'react-relay';
import modernEnvironment from './environment';

const mutation = graphql`
  mutation LoginMutation($input: LoginInput!) {
    login(input: $input) {
      session {
        token
      }
    }
  }
`;

let tempID = 0;
export default {
  commit: (inputVariables, config = {}) => {
    return new Promise((resolve, reject) => {
      const { email, password } = inputVariables;
      commitMutation(modernEnvironment, {
        mutation,
        variables: {
          input: {
            email,
            password, 
            clientMutationId: `login${tempID++}`,
          },
        },
        onCompleted: response => resolve(response),
        onError: error => reject(error),
      });
    });
  },
};