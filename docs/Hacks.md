# Hacks Collection

A collection of ways to hack the NVIDIA Cards to do amazing things.

Note:  All commands need sudo

## NVIDIA Driver (nvidia-smi)

### Persistance Mode

Keep the settings of the GPU even if the driver reloads the card.  Run in conjunction with other commands.

```
nvidia-smi -pm
```

### Reduce Power Limit

Set the power limit (`-pl`) on a specific card (`-i`).

```
nvidia-smi -i 0 -pl 140
```


