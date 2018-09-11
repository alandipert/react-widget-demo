class ClockComponent extends React.Component {
  render() {
      return <div>Time:<span>{this.props.time}</span></div>;
  }
}

var ClockOutputBinding = {
    find: function(scope)  {
        return $(scope).find("clockOutput");
    },
    getId: function(el) {
        return el.id;
    },
    renderValue: function(el, data) {
        ReactDOM.render(
            <ClockComponent time={new Date(data.timestamp).toLocaleTimeString()}/>,
            el
        );
    },
    renderError: function(el, err) {
        throw new Error("Not implemented");
    },
    clearError: function(el) {
        throw new Error("Not implemented");
    }
};

Shiny.outputBindings.register(ClockOutputBinding, "org.dipert.clockOutputBinding");
