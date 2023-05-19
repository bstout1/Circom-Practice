pragma circom 2.0.0;

template Multiplier2() {
    signal input a;
    signal input b;
    signal output c;

    c <== a*b;
}

template Multiply(N) {
    signal input in[N];
    signal output out;
    // We will need N-1 multiply 2 circuits, which we can store as an array of components
    component comp[N-1];

    //assign a multiply2 circuit to each component
    for(var i=0; i<N-1; i++) {
        comp[i] = Multiplier2();
    }

    //Now we need to assign the inputs to each component wire

    comp[0].a<==in[0];
    comp[0].b<==in[1];
    for(var i=1; i<N-1;i++){
        comp[i].a<==in[i];
        comp[i].b<==comp[i-1].c;
    }
}

component main {public [in]}= Multiply(4);