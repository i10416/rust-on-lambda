use lambda_runtime::{
    run, service_fn, tracing,
    Error as LambdaError, LambdaEvent,
};
use core::do_some_complex_task;

#[tokio::main]
async fn main() -> Result<(), LambdaError> {
    run(service_fn(lambda_app)).await
}

#[tracing::instrument]
async fn lambda_app(
    _: LambdaEvent<serde_json::Value>,
) -> Result<(), LambdaError> {
    do_some_complex_task().await;
    Ok(())
}
