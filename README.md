# Sim IDX Herd

**This is a migration of Herd's sim Studio lambdas to Sim IDX listeners**

Original canvas: https://studio.sim.io/ilemi/canvases/87b6a422-0a1e-43ca-944a-f21c49873b43

# Deployments

```
sim deploy --environment prod
```

See progress of the deployments in the developer portal.

## Deleting existing deployment

```
sim deploy delete --deployment-id <deployment-id>
```

# Development

## Building
```
sim build
```

## Evaluating listeners

```
sim listeners evaluate --start-block=23131640 --end-block=23131641 --chain-id=1
```

## Running Forge tests
```
sim test
```
