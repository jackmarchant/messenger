import { graphql, commitMutation } from 'react-relay';
import modernEnvironment from './environment';

const mutation = graphql`
  mutation CreateUserMutation($input: CreateUserInput!) {
    createUser(input: $input) {
      user {
        id
      }
    }
  }
`;

let tempID = 0;
export default {
  commit: (inputVariables, config = {}) => {
    return new Promise((resolve, reject) => {
      const { firstname, lastname, email, password } = inputVariables;
      commitMutation(modernEnvironment, {
        mutation,
        variables: {
          input: {
            firstname,
            lastname,
            email,
            password, 
            clientMutationId: `createUser${tempID++}`,
          },
        },
        onCompleted: response => resolve(response),
        onError: error => reject(error),
      });
    });
  },
};