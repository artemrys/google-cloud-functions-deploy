from bitbucket_pipes_toolkit import Pipe, get_logger

logger = get_logger()

schema = {
  'NAME': {'type': 'string', 'required': False, 'default': 'test'},
  'DEBUG': {'type': 'boolean', 'required': False, 'default': False}
}


class GoogleCloudFunctionDeployPipe(Pipe):
    def run(self):
        super().run()

        logger.info('Executing the pipe...')
        name = self.get_variable('NAME')

        print(name)

        self.success(message="Success!")


if __name__ == '__main__':
    pipe = GoogleCloudFunctionDeployPipe(pipe_metadata='/pipe.yml', schema=schema)
    pipe.run()

