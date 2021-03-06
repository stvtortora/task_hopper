import { INVALID_LOCATION } from '../actions/form_actions';
import { ADD_TO_TASK } from '../actions/tasks_actions';

const locationErrorsReducer = (state = [], action) => {
  switch(action.type) {
    case INVALID_LOCATION:
      return ["Location can't be blank."];
    case ADD_TO_TASK:
      return [];
    default:
      return state;
  }
}

export default locationErrorsReducer;
