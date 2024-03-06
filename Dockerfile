FROM ubuntu:focal AS builder

RUN apt update -y
RUN apt install build-essential python3 libmpfr6 libmpc3 libssl-dev wget -y

WORKDIR /os161


FROM builder AS binutils

RUN wget http://www.os161.org/download/binutils-2.24+os161-2.1.tar.gz \
    && tar -xvzf binutils-2.24+os161-2.1.tar.gz \
    && rm binutils-2.24+os161-2.1.tar.gz

WORKDIR /os161/binutils-2.24+os161-2.1

RUN find . -name '*.info' | xargs touch \
    && touch intl/plural.c \
    && cd .. 

RUN ./configure --nfp --disable-werror --target=mips-harvard-os161 --prefix=/os161/tools
RUN make -j $(nproc)
RUN make install -j $(nproc)


FROM builder AS funny-gcc
RUN wget http://www.os161.org/download/gcc-4.8.3+os161-2.1.tar.gz \
    && tar -xvzf gcc-4.8.3+os161-2.1.tar.gz \
    && rm gcc-4.8.3+os161-2.1.tar.gz

RUN apt install libgmp-dev libmpfr-dev libmpc-dev -y
COPY --from=binutils /os161/tools /os161/tools

RUN mkdir buildgcc
WORKDIR /os161/buildgcc

ENV CXXFLAGS --std=c++03

RUN ../gcc-4.8.3+os161-2.1/configure \
    --enable-languages=c,lto \
    --nfp --disable-shared --disable-threads \
    --disable-libmudflap --disable-libssp \
    --disable-libstdcxx --disable-nls \
    --target=mips-harvard-os161 \
    --prefix=/os161/tools

RUN make -j $(nproc)
RUN make install -j $(nproc)


FROM builder AS gdb
RUN wget http://www.os161.org/download/gdb-7.8+os161-2.1.tar.gz \
    && tar -xvzf gdb-7.8+os161-2.1.tar.gz \
    && rm gdb-7.8+os161-2.1.tar.gz

RUN apt install libncurses5-dev -y

COPY --from=funny-gcc /os161/tools /os161/tools

WORKDIR /os161/gdb-7.8+os161-2.1

ENV CFLAGS --std=gnu89

RUN ./configure --target=mips-harvard-os161 --prefix=/os161/tools --with-python=no
RUN make -j $(nproc) 
RUN make install -j $(nproc)


FROM builder AS system161
RUN wget http://www.os161.org/download/sys161-2.0.8.tar.gz \
    && tar -xvzf sys161-2.0.8.tar.gz \
    && rm sys161-2.0.8.tar.gz

WORKDIR /os161/sys161-2.0.8

COPY --from=gdb /os161/tools /os161/tools

ENV CFLAGS -fcommon

RUN ./configure --prefix=/os161/tools mipseb
RUN make -j $(nproc) 
RUN make install -j $(nproc)


FROM builder AS final
RUN apt install bmake git zsh curl -y
RUN echo '\n' | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN chsh -s $(which zsh)

COPY --from=system161 /os161/tools /os161/tools
WORKDIR /os161/tools/bin
RUN sh -c 'for i in mips-*; do ln -s $i os161-`echo $i | cut -d- -f4-`; done'
RUN echo "set auto-load safe-path /" > ~/.gdbinit

# RUN mkdir -p ~/cs3231/root/ 
# RUN echo "set can-use-hw-watchpoints 0" >> ~/cs3231/root/.gdbinit
# RUN echo "define connect" >> ~/cs3231/root/.gdbinit
# RUN echo "dir ~/cs3231/warmup-src/kern/compile/WARMUP" >> ~/cs3231/root/.gdbinit
# RUN echo "target remote unix:.sockets/gdb" >> ~/cs3231/root/.gdbinit
# RUN echo "b panic" >> ~/cs3231/root/.gdbinit
# RUN echo "end" >> ~/cs3231/root/.gdbinit


ENV PATH="${PATH}:/os161/tools/bin"
WORKDIR /os161

ENTRYPOINT [ "sleep", "infinity" ]