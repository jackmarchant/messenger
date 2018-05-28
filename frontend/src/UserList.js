import React from 'react';
import { createFragmentContainer, graphql } from 'react-relay';
import CreateThreadMutation from './CreateThreadMutation';
import { withRouter } from 'react-router-dom';
import get from 'lodash.get';
import { List, Subheader, ListItem, Avatar } from 'material-ui';

const createThreadWithUser = (userId, history) => {
  CreateThreadMutation.commit({
    userId,
  }).then(response => {
    history.push(`/thread/${get(response, 'createThread.thread.slug')}`)
  });
};

const UserList = ({ data, history }) => {
  if (!data.users) {
    return null;
  }
  return (
    <List>
      <Subheader><h2>Contacts</h2></Subheader>
      {data.users.map(({ id, firstname, lastname }, index) => 
        <ListItem
          key={`user-${index}`}
          onClick={() => createThreadWithUser(id, history)}
          primaryText={`${firstname} ${lastname}`}
          leftAvatar={<Avatar src="https://loremflickr.com/100/100/people" />}
        />
      )}
    </List>
  );
};

export { UserList };
export default createFragmentContainer(
  withRouter(UserList),
  graphql`
    fragment UserList on Query {
      users {
        id
        firstname
        lastname
        email
      }
    }
  `
);