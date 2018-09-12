/*
   A simple React component with no state.
 */
class ClockComponent extends React.Component {
    render() {
        /*
           The props convention here is:
           - props.data is the `data` object passed to renderValue (Shiny's API)
           - props.dataset is the `dataset` object, which is the object of data-* attributes from the root DOM element
         */
        let timeString = new Date(this.props.data.unixTimeMs)
            .toLocaleTimeString(this.props.dataset.locale);
        return <div>Time: <span>{timeString}</span></div>
    }
}

/*
   Wraps a React component with a Shiny.OutputBinding. Calls to renderValue are
   forwarded to ReactDOM.render. props come from the `data` object passed to
   renderValue and the data-* attributes on the root element.
 */
class ReactOutputBinding extends Shiny.OutputBinding {
    constructor(component, selector) {
        super()
        this.component = component;
        this.findSelector = selector;
    }
    find(scope) {
        return $(scope).find(this.findSelector);
    }
    renderValue(el, data) {
        ReactDOM.render(React.createElement(this.component, {data: data, dataset: el.dataset}), el)
    }
}

Shiny.outputBindings.register(new ReactOutputBinding(ClockComponent, ".clock-output"))
/* Necessary because of JSX/Babel-standalone */
Shiny.bindAll();
