use lambda_extension::{tracing, LambdaEvent, NextEvent, Error};

pub(crate) async fn events_processor(event: LambdaEvent) -> Result<(), Error> {
    match event.next {
        NextEvent::Shutdown(event) => {
            tracing::info!(event_type = "shutdown", ?event, "shutting down function");
        }
        NextEvent::Invoke(event) => {
            tracing::info!(event_type = "invoke", ?event, "invoking function");
        }
    }
    Ok(())
}
