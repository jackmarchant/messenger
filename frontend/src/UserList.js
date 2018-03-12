import React, { Fragment } from 'react';
import { createFragmentContainer, graphql } from 'react-relay';
import CreateThreadMutation from './CreateThreadMutation';
import RaisedButton from 'material-ui/RaisedButton';
import { withRouter } from 'react-router-dom';
import get from 'lodash.get';

import './User.css';

const createThreadWithUser = ({ id, firstname, lastname }, history) => {
  CreateThreadMutation.commit({
    userId: id,
    participants: [id], // need to add "current user"
    name: `${firstname} ${lastname} ${Math.random()}`,
  }).then(response => {
    history.push(`/thread/${get(response, 'createThread.thread.slug')}`)
  });
};

const User = (props) => {
  const { firstname, lastname, id, history } = props;
  return (
    <div className="l-flex-grid">
      <div className="l-flex-grid__item">
        <p className="c-user__name">{firstname} {lastname}</p>
      </div>
      <div className="l-flex-grid__item">
        <RaisedButton 
          onClick={() => createThreadWithUser({ firstname, lastname, id}, history)} 
        >
          Message
        </RaisedButton>
      </div>
    </div>
  );
};

const UserWithRouter = withRouter(User);

const UserList = ({ data }) => {
  return (
    <Fragment>
      <h2>Contacts</h2>
      {data.users.map((user, index) => 
        <Fragment key={`user-${index}`}>
          <UserWithRouter {...user} />
        </Fragment>
      )}
    </Fragment>
  );
};

export { UserList };
export default createFragmentContainer(
  UserList,
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